import { Module } from '@nestjs/common';
import { CookieService } from './services/cookie.service';
import { ConfigModule, ConfigType } from '@nestjs/config';
import { JwtModule } from '@nestjs/jwt';
import accessTokenConfig from 'src/refresh-token/config/access-token.config';

@Module({
  imports: [
    ConfigModule,
    JwtModule.registerAsync({
      imports: [ConfigModule.forFeature(accessTokenConfig)],
      inject: [accessTokenConfig.KEY],
      useFactory: (atConfig: ConfigType<typeof accessTokenConfig>) => ({
        secret: atConfig.signOptions.secret,
        signOptions: atConfig.signOptions,
      }),
    }),
  ],
  providers: [CookieService],
  exports: [CookieService],
})
export class CommonModule {}
