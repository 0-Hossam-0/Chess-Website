import { UserErrorMessages } from 'src/users/errors/message-user.error';

export class AuthErrorMessages extends UserErrorMessages {
  static alreadyExists(field: string): string {
    return `${field} is already taken. Please try another one.`;
  }
  static invalidIdentifier(): string {
    return 'Please enter a valid username or email address.';
  }
  static invalidOtpCode(): string {
    return 'Invalid Otp format provided';
  }
}
