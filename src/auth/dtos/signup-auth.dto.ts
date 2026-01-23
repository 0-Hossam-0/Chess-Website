import {
  IsEmail,
  IsNotEmpty,
  IsString,
  MaxLength,
  MinLength,
  Matches,
} from 'class-validator';
import { AuthErrorMessages } from '../error/message-auth.error';
import { UserDefinitions } from 'src/users/definitions/user.definition';

/**
 * Data Transfer Object for User Registration.
 * Handles validation for new user accounts.
 */
export class SignUpDto {
  /**
   * User's legal first name.
   * @example 'John'
   * @constraint Only letters allowed.
   */
  @Matches(UserDefinitions.REGEX.NAME, {
    message: AuthErrorMessages.onlyLetters('First Name'),
  })
  @MaxLength(UserDefinitions.LIMITS.NAME_MAX_LENGTH, {
    message: AuthErrorMessages.maxLength(
      'First Name',
      UserDefinitions.LIMITS.NAME_MAX_LENGTH,
    ),
  })
  @IsString({ message: AuthErrorMessages.isString('First Name') })
  @IsNotEmpty({ message: AuthErrorMessages.required('First Name') })
  firstName: string;

  /**
   * User's legal last name.
   * @example 'Doe'
   * @constraint Only letters allowed.
   */
  @Matches(UserDefinitions.REGEX.NAME, {
    message: AuthErrorMessages.onlyLetters('Last Name'),
  })
  @MaxLength(UserDefinitions.LIMITS.NAME_MAX_LENGTH, {
    message: AuthErrorMessages.maxLength(
      'Last Name',
      UserDefinitions.LIMITS.NAME_MAX_LENGTH,
    ),
  })
  @IsString({ message: AuthErrorMessages.isString('Last Name') })
  @IsNotEmpty({ message: AuthErrorMessages.required('Last Name') })
  lastName: string;

  /**
   * Unique handle for the user.
   * @example 'johndoe_88'
   * @constraint 3-20 characters, alphanumeric, dots, or underscores.
   */
  @Matches(UserDefinitions.REGEX.USERNAME, {
    message: AuthErrorMessages.alphaNumeric('Username'),
  })
  @MaxLength(UserDefinitions.LIMITS.USERNAME_MAX_LENGTH, {
    message: AuthErrorMessages.maxLength(
      'Username',
      UserDefinitions.LIMITS.USERNAME_MAX_LENGTH,
    ),
  })
  @MinLength(UserDefinitions.LIMITS.USERNAME_MIN_LENGTH, {
    message: AuthErrorMessages.minLength(
      'Username',
      UserDefinitions.LIMITS.USERNAME_MIN_LENGTH,
    ),
  })
  @IsString({ message: AuthErrorMessages.isString('Username') })
  @IsNotEmpty({ message: AuthErrorMessages.required('Username') })
  username: string;

  /**
   * Primary contact and login email. Must be unique.
   * @example 'john.doe@example.com'
   */
  @IsEmail({}, { message: AuthErrorMessages.invalidEmail() })
  @IsNotEmpty({ message: AuthErrorMessages.required('Email') })
  email: string;

  /**
   * Secure password for the account.
   * @constraint Min 8 chars, 1 uppercase, 1 lowercase, 1 number.
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
  @IsString({ message: AuthErrorMessages.isString('Password') })
  @IsNotEmpty({ message: AuthErrorMessages.required('Password') })
  password: string;
}
