import {
  IsNotEmpty,
  IsString,
  Matches,
  MaxLength,
  MinLength,
} from 'class-validator';
import { AuthErrorMessages } from '../error/message-auth.error';
import { UserDefinitions } from 'src/users/definitions/user.definition';
import { IsUsernameOrEmail } from 'src/common/decorator/isUsernameOrEmail.decorator';
/**
 * Data Transfer Object for User Authentication.
 * Used to validate credentials during the sign-in process.
 */
export class SignInDto {
  /**
   * The user's primary identifier for authentication.
   * * This field is polymorphic and accepts either:
   * 1. A **Username**: Must match alphanumeric constraints (3-20 chars).
   * 2. An **Email**: Must be a valid RFC-compliant email address.
   * * @example 'johndoe77'
   * @example 'john.doe@example.com'
   * @see UserDefinitions.REGEX - For exact pattern implementations.
   */
  @IsUsernameOrEmail({
    message: AuthErrorMessages.invalidIdentifier(),
  })
  @IsString({
    message: AuthErrorMessages.isString('Username or Email'),
  })
  @IsNotEmpty({
    message: AuthErrorMessages.required('Username or Email'),
  })
  usernameOrEmail: string;

  /**
   * The account password.
   * Validated for length and complexity to ensure security standards.
   * @example 'P@ssword123'
   * @constraint Must match the original registration complexity rules.
   */
  @Matches(UserDefinitions.REGEX.PASSWORD, {
    message: AuthErrorMessages.invalidPassword(),
  })
  @MaxLength(UserDefinitions.LIMITS.PASSWORD_MAX_LENGTH, {
    message: AuthErrorMessages.maxLength(
      'Password',
      UserDefinitions.LIMITS.PASSWORD_MAX_LENGTH,
    ),
  })
  @MinLength(UserDefinitions.LIMITS.PASSWORD_MIN_LENGTH, {
    message: AuthErrorMessages.minLength(
      'Password',
      UserDefinitions.LIMITS.PASSWORD_MIN_LENGTH,
    ),
  })
  @IsString({
    message: AuthErrorMessages.isString('Password'),
  })
  @IsNotEmpty({
    message: AuthErrorMessages.required('Password'),
  })
  password: string;
}
