export class UserDefinitions {
  static readonly LIMITS = {
    NAME_MIN_LENGTH: 2,
    NAME_MAX_LENGTH: 50,
    USERNAME_MIN_LENGTH: 3,
    USERNAME_MAX_LENGTH: 20,
    PASSWORD_MIN_LENGTH: 8,
    PASSWORD_MAX_LENGTH: 128,
  };
  static readonly REGEX = {
    NAME: /^[a-zA-Z]+$/,

    USERNAME: /^(?=[a-zA-Z0-9._]{3,20}$)(?!.*[_.]{2})[^_.].*[^_.]$/,

    EMAIL: /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/,

    PASSWORD:
      /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{8,128}$/,
  };
}
