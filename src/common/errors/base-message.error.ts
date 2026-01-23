export class BaseErrorMessages {
  static required(field: string): string {
    return `${field} is required.`;
  }

  static minLength(field: string, min: number): string {
    return `${field} must be at least ${min} characters long.`;
  }

  static maxLength(field: string, max: number): string {
    return `${field} cannot exceed ${max} characters.`;
  }

  static isString(field: string): string {
    return `${field} must be a valid string.`;
  }

  static isNumber(field: string): string {
    return `${field} must be a valid number.`;
  }
}
