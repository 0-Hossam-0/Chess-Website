import {
  registerDecorator,
  ValidationOptions,
  ValidatorConstraint,
  ValidatorConstraintInterface,
} from 'class-validator';
import { UserDefinitions } from 'src/users/definitions/user.definition';

@ValidatorConstraint({ name: 'isUsernameOrEmail', async: false })
export class IsUsernameOrEmailConstraint implements ValidatorConstraintInterface {
  validate(value: any) {
    if (typeof value !== 'string') return false;
    const isEmail = UserDefinitions.REGEX.EMAIL.test(value);
    const isUsername = UserDefinitions.REGEX.USERNAME.test(value);

    return isEmail || isUsername;
  }
}

export function IsUsernameOrEmail(validationOptions?: ValidationOptions) {
  return function (object: Object, propertyName: string) {
    registerDecorator({
      target: object.constructor,
      propertyName: propertyName,
      options: validationOptions,
      constraints: [],
      validator: IsUsernameOrEmailConstraint,
    });
  };
}
