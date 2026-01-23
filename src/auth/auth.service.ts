import {
  BadRequestException,
  ConflictException,
  Injectable,
} from '@nestjs/common';
import { SignInDto } from './dtos/signin-auth.dto';
import { SignUpDto } from './dtos/signup-auth.dto';
import {
  ForgetPasswordConfirmDto,
  ForgetPasswordRequestDto,
} from './dtos/forget-password-auth.dto';
import { UsersService } from 'src/users/users.service';
import { RefreshTokenService } from 'src/refresh-token/refresh-token.service';
import bcrypt from 'bcrypt';
import { AuthErrorMessages } from './error/message-auth.error';
import { IPayload } from 'src/refresh-token/types/payload.types';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly refreshTokenService: RefreshTokenService,
  ) {}
  async signIn(signInDto: SignInDto) {

      const user = await this.usersService.findOneByIdentifier(
        signInDto.usernameOrEmail,
      );

    if (!user || !(await bcrypt.compare(signInDto.password, user.password)))
      throw new BadRequestException('Invalid credentials provided.');

    const accessToken = await this.refreshTokenService.createAccessToken(user);
    const refreshToken =
    await this.refreshTokenService.createRefreshToken(user);

    return {
      accessToken,
      refreshToken,
      user: { uuid: user.uuid, username: user.username },
    };
  }

  async signUp(signUpDto: SignUpDto) {
    const existingUser = await this.usersService.findOneByIdentifier(
      signUpDto.username,
    );
    const existingEmail = await this.usersService.findOneByIdentifier(
      signUpDto.email,
    );

    if (existingUser)
      throw new ConflictException(AuthErrorMessages.alreadyExists('Username'));

    if (existingEmail)
      throw new ConflictException(AuthErrorMessages.alreadyExists('Email'));

    const user = await this.usersService.create(signUpDto);

    const { password, ...result } = user;
    return result;
  }

  async checkAvailability(username?: string, email?: string) {
    if (username && email)
      throw new BadRequestException('Provide only one attribute');

    if (username) {
      const user = await this.usersService.findOneByIdentifier(username);
      return { available: !user };
    }

    if (email) {
      const user = await this.usersService.findOneByIdentifier(email);
      return { available: !user };
    }

    throw new BadRequestException('Provide username or email');
  }

  forgetPasswordRequest(forgetPasswordRequestDto: ForgetPasswordRequestDto) {}
  forgetPasswordConfirm(forgetPasswordConfirmDto: ForgetPasswordConfirmDto) {}
  refreshToken(user: IPayload) {
  }
}
