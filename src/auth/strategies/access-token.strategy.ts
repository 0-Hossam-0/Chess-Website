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
import accessTokenConfig from 'src/refresh-token/config/access-token.config';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AccessTokenStrategy extends PassportStrategy(
  Strategy,
  'jwt-access',
) {
  constructor(
    @Inject(accessTokenConfig.KEY)
    private readonly atConfig: ConfigType<typeof accessTokenConfig>,
    private readonly jwtService: JwtService,
  ) {
    super({
      jwtFromRequest: ExtractJwt.fromExtractors([
        (request: Request) => {
          return request.cookies[this.atConfig.cookieKey!];
        },
      ]),
      passReqToCallback: true,
      ignoreExpiration: false,
      secretOrKey: atConfig.signOptions.secret,
    });
  }

  async validate(req: Request, payload: IPayload) {
    const accessToken = req.cookies[this.atConfig.cookieKey];

    const isMatch = await this.jwtService.verify(accessToken);

    if (!isMatch) throw new UnauthorizedException('Invalid token');

    return {
      ...payload,
    };
  }
}
