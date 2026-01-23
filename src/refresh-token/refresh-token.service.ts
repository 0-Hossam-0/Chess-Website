import { Inject, Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import refreshTokenConfig from './config/refresh-token.config';
import type { ConfigType } from '@nestjs/config';
import { InjectRepository } from '@nestjs/typeorm';
import { RefreshToken } from 'src/auth/entities/refresh-token.entity';
import { Repository } from 'typeorm';
import accessTokenConfig from './config/access-token.config';
import bcrypt from 'bcrypt';
import { User } from 'src/users/entities/user.entity';
import { IPayload } from './types/payload.types';
import ms from 'ms';

@Injectable()
export class RefreshTokenService {
  constructor(
    private readonly jwtService: JwtService,
    @InjectRepository(RefreshToken)
    private readonly refreshTokenRepository: Repository<RefreshToken>,
    @Inject(refreshTokenConfig.KEY)
    private readonly rtConfig: ConfigType<typeof refreshTokenConfig>,
    @Inject(accessTokenConfig.KEY)
    private readonly atConfig: ConfigType<typeof accessTokenConfig>,
  ) {}
  async createAccessToken(user: User) {
    const payload = {
      uuid: user.uuid,
      username: user.username,
      email: user.email,
    };
    return await this.jwtService.signAsync(payload, {
      ...this.atConfig.signOptions,
    });
  }
  async createRefreshToken(user: User) {
    const session = await this.refreshTokenRepository.save({
      userUuid: user.uuid,
      token: 'pending',
      expiresAt: new Date(Date.now() + this.rtConfig.signOptions.expiresIn),
    });

    const payload = {
      sub: user.uuid,
      sessionId: session.id,
    };

    const refreshToken = await this.jwtService.signAsync(
      payload,
      this.rtConfig.signOptions,
    );

    const hashedToken = await bcrypt.hash(refreshToken, 10);
    const updated = await this.refreshTokenRepository.update(session.id, {
      token: hashedToken,
    });

    return refreshToken;
  }
}
