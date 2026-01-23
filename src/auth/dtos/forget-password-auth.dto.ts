import { IsEmail, IsNotEmpty, IsString, Matches } from 'class-validator';
import { AuthErrorMessages } from '../error/message-auth.error';
import { AuthDefinitions } from '../definitions/auth.definition';

export class ForgetPasswordRequestDto {
  @IsEmail({}, { message: AuthErrorMessages.invalidEmail() })
  @IsNotEmpty({ message: AuthErrorMessages.required('Email') })
  email: string;
}

export class ForgetPasswordConfirmDto {
  @IsEmail({}, { message: AuthErrorMessages.invalidEmail() })
  @IsNotEmpty({ message: AuthErrorMessages.required('Email') })
  email: string;

  @Matches(AuthDefinitions.REGEX.OTP_CODE, {
    message: AuthErrorMessages.invalidOtpCode(),
  })
  @IsString({ message: AuthErrorMessages.isString('OTP Code') })
  @IsNotEmpty({ message: AuthErrorMessages.required('OTP Code') })
  otpCode: string;
}
