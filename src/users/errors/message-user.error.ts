import { BaseErrorMessages } from 'src/common/errors/base-message.error';

export class UserErrorMessages extends BaseErrorMessages {
  static onlyLetters(field: string): string {
    return `${field} must only contain letters (a-z, A-Z).`;
  }

  static invalidUsername(): string {
    return this.alphaNumeric('Username') + ' (3-20 characters).';
  }

  static alphaNumeric(field: string): string {
    return `${field} must only contain letters and numbers.`;
  }

  static invalidPassword(): string {
    return 'Password must contain at least one uppercase letter, one lowercase letter, and one number.';
  }

  static invalidEmail(): string {
    return 'Please provide a valid email address (e.g., user@example.com).';
  }
}
