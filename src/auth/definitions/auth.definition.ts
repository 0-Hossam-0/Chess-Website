import { BaseDefinitions } from 'src/common/definitions/base.definition';

export class AuthDefinitions implements BaseDefinitions {
  static readonly REGEX = {
    OTP_CODE: /^\d{6}$/,
  };
}
