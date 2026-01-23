import { Module } from '@nestjs/common';
import { RefreshTokenService } from './refresh-token.service';
import { RefreshTokenController } from './refresh-token.controller';
import { JwtModule, JwtService } from '@nestjs/jwt';
import accessTokenConfig from './config/access-token.config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RefreshToken } from 'src/auth/entities/refresh-token.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([RefreshToken]),
    JwtModule.registerAsync(accessTokenConfig.asProvider()),
  ],
  controllers: [RefreshTokenController],
  providers: [RefreshTokenService, JwtService],
  exports: [RefreshTokenService],
})
export class RefreshTokenModule {}
