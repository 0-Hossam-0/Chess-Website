import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  HttpCode,
  HttpStatus,
  Query,
  Req,
  UseGuards,
  Res,
  Inject,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import { SignInDto } from './dtos/signin-auth.dto';
import { SignUpDto } from './dtos/signup-auth.dto';
import {
  ForgetPasswordConfirmDto,
  ForgetPasswordRequestDto,
} from './dtos/forget-password-auth.dto';
import { RefreshTokenGuard } from './guards/rt-guard/refresh-token.guard';
import type { Response } from 'express';
import { CookieService } from 'src/common/services/cookie.service';
import type { AuthRequest } from './types/request-auth.type';
import { RefreshTokenService } from 'src/refresh-token/refresh-token.service';
import type { ConfigType } from '@nestjs/config';
import accessTokenConfig from 'src/refresh-token/config/access-token.config';

@Controller('api/auth')
export class AuthController {
  constructor(
    private readonly authService: AuthService,
    private readonly cookieService: CookieService,
    private readonly refreshTokenService: RefreshTokenService,
    @Inject(accessTokenConfig.KEY)
    private readonly atConfig: ConfigType<typeof accessTokenConfig>,
  ) {}

  @HttpCode(HttpStatus.OK)
  @Post('sign-in')
  async signIn(
    @Body() signInDto: SignInDto,
    @Res({ passthrough: true }) res: Response,
  ) {
    const { accessToken, refreshToken, user } =
      await this.authService.signIn(signInDto);
    this.cookieService.setAuthCookies({ res, accessToken, refreshToken });

    return { message: 'Sign In success', user };
  }

  @HttpCode(HttpStatus.CREATED)
  @Post('sign-up')
  signUp(@Body() signUpDto: SignUpDto) {
    return this.authService.signUp(signUpDto);
  }

  @Post('forget-password/request')
  forgetPasswordRequest(
    @Body() forgetPasswordRequestDto: ForgetPasswordRequestDto,
  ) {
    return this.authService.forgetPasswordRequest(forgetPasswordRequestDto);
  }

  @Patch('forget-password/confirm')
  forgetPasswordConfirm(
    @Body() forgetPasswordConfirmDto: ForgetPasswordConfirmDto,
  ) {
    return this.authService.forgetPasswordConfirm(forgetPasswordConfirmDto);
  }

  @Get('check-availability')
  async checkAvailability(
    @Query('username') username?: string,
    @Query('email') email?: string,
  ) {
    return this.authService.checkAvailability(username, email);
  }
  @UseGuards(RefreshTokenGuard)
  @Post('refresh')
  async refresh(
    @Req() req: AuthRequest,
    @Res({ passthrough: true }) res: Response,
  ) {
    const accessToken = await this.refreshTokenService.createAccessToken(
      req.user,
    );
    this.cookieService.setAccessTokenCookie(res, accessToken);
    return { message: 'Token successfully refreshed' };
  }
}
