import type { ConfigType } from '@nestjs/config';
import { ConfigService } from '@nestjs/config';
import { IClearCookie, ICreateCookie } from './types/cookie.type';
import { Inject, Injectable } from '@nestjs/common';
import accessTokenConfig from 'src/refresh-token/config/access-token.config';
import refreshTokenConfig from 'src/refresh-token/config/refresh-token.config';

@Injectable()
export class CookieService {
  constructor(
    private readonly configService: ConfigService,
    @Inject(accessTokenConfig.KEY)
    private readonly atConfig: ConfigType<typeof accessTokenConfig>,
    @Inject(refreshTokenConfig.KEY)
    private readonly rtConfig: ConfigType<typeof refreshTokenConfig>,
  ) {}
  setCookie({ res, cookieKey, cookieValue, path, maxAge }: ICreateCookie) {
    res.cookie(cookieKey, cookieValue, {
      httpOnly: true,
      secure: this.configService.get('NODE_ENV') === 'production',
      sameSite: 'lax',
      path,
      maxAge,
    });
  }
  setAccessTokenCookie(res, accessToken) {
    res.cookie(this.atConfig.cookieKey, accessToken, {
      httpOnly: true,
      secure: this.configService.get('NODE_ENV') === 'production',
      sameSite: 'lax',
      path: this.atConfig.path,
      maxAge: this.atConfig.signOptions.expiresIn,
    });
  }

  setAuthCookies({
    res,
    accessToken,
    refreshToken,
  }: {
    res;
    accessToken: string;
    refreshToken: string;
  }) {
    const accessKey = this.atConfig.cookieKey;
    const refreshKey = this.rtConfig.cookieKey;
    const accessMaxAge = this.rtConfig.signOptions.expiresIn;
    const refreshMaxAge = this.rtConfig.signOptions.expiresIn;
    res.cookie(accessKey, accessToken, {
      httpOnly: true,
      secure: this.configService.get('NODE_ENV') === 'production',
      sameSite: 'lax',
      path: this.atConfig.path,
      maxAge: accessMaxAge,
    });

    res.cookie(refreshKey, refreshToken, {
      httpOnly: true,
      secure: this.configService.get('NODE_ENV') === 'production',
      sameSite: 'lax',
      path: this.rtConfig.path,
      maxAge: refreshMaxAge,
    });
  }

  clearCookie({ res, cookieKey }: IClearCookie) {
    return res.clearCookie(cookieKey);
  }
}
