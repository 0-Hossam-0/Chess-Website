import { PassportStrategy } from '@nestjs/passport';
import { ExtractJwt, Strategy } from 'passport-jwt';
import { Request } from 'express';
import { Injectable, Inject, UnauthorizedException } from '@nestjs/common';
import type { ConfigType } from '@nestjs/config';
import refreshTokenConfig from 'src/refresh-token/config/refresh-token.config';
import { IPayload } from 'src/refresh-token/types/payload.types';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { RefreshToken } from '../entities/refresh-token.entity';
import bcrypt from 'bcrypt';

@Injectable()
export class RefreshTokenStrategy extends PassportStrategy(
  Strategy,
  'jwt-refresh',
) {
  constructor(
    @Inject(refreshTokenConfig.KEY)
    private readonly rtConfig: ConfigType<typeof refreshTokenConfig>,
    @InjectRepository(RefreshToken)
    private readonly refreshTokenRepository: Repository<RefreshToken>,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        (request: Request) => {
          return request.cookies[this.rtConfig.cookieKey!];
        },
      ]),
      passReqToCallback: true,
      ignoreExpiration: false,
      secretOrKey: rtConfig.signOptions.secret,
    });
  }

  async validate(req: Request, payload: IPayload) {
    const refreshToken = req.cookies[this.rtConfig.cookieKey];
    const storedRecord = await this.refreshTokenRepository.findOne({
      where: {
        userUuid: payload.uuid,
        isRevoked: false,
      },
    });

    if (!storedRecord) throw new UnauthorizedException('Session not found');

    const isMatch = await bcrypt.compare(refreshToken, storedRecord.token);

    if (!isMatch) throw new UnauthorizedException('Invalid refresh token');

    return {
      ...payload,
    };
  }
}
