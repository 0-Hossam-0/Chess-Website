import { Module } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthController } from './auth.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersService } from 'src/users/users.service';
import { User } from 'src/users/entities/user.entity';
import { JwtModule } from '@nestjs/jwt';
import { RefreshTokenModule } from 'src/refresh-token/refresh-token.module';
import { RefreshToken } from './entities/refresh-token.entity';
import { RefreshTokenStrategy } from './strategies/refresh-token.strategy';
import refreshTokenConfig from 'src/refresh-token/config/refresh-token.config';
import { ConfigModule } from '@nestjs/config';
import { CookieService } from 'src/common/services/cookie.service';
import { CommonModule } from 'src/common/common.module';

@Module({
  imports: [
    RefreshTokenModule,
    CommonModule,
    JwtModule.register({}),
    TypeOrmModule.forFeature([User]),
    ConfigModule.forFeature(refreshTokenConfig),
    TypeOrmModule.forFeature([RefreshToken]),
  ],
  controllers: [AuthController],
  providers: [UsersService, AuthService, RefreshTokenStrategy, CookieService],
})
export class AuthModule {}
