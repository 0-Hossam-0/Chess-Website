import { BadRequestException } from '@nestjs/common';
import {
  BeforeInsert,
  BeforeUpdate,
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import * as bcrypt from 'bcrypt';
import { UserDefinitions } from '../definitions/user.definition';
import { UserErrorMessages } from '../errors/message-user.error';

@Entity('user')
export class User {
  @PrimaryGeneratedColumn('uuid')
  uuid: string;

  @Column({
    type: 'varchar',
    length: UserDefinitions.LIMITS.NAME_MAX_LENGTH,
    comment: 'Strictly alphabetic names',
  })
  firstName: string;

  @Column({
    type: 'varchar',
    length: UserDefinitions.LIMITS.NAME_MAX_LENGTH,
  })
  lastName: string;

  @Column({
    unique: true,
    length: UserDefinitions.LIMITS.USERNAME_MAX_LENGTH,
  })
  username: string;

  @Column({ default: 1200 })
  eloRating: number;

  @Column({ unique: true })
  email: string;

  @Column({ select: false })
  password: string;

  @Column({ nullable: true })
  avatarUrl: string;

  @CreateDateColumn()
  createdAt: Date;

  @UpdateDateColumn()
  lastUpdate: Date;

  @BeforeInsert()
  @BeforeUpdate()
  async handlePersistenceLogic() {
    this.validateData();

    if (this.password) {
      const isAlreadyHashed = this.password.startsWith('$2b$');

      if (!isAlreadyHashed) {
        const saltRounds = 10;
        this.password = await bcrypt.hash(this.password, saltRounds);
      }
    }
  }

  private validateData() {
    if (!UserDefinitions.REGEX.NAME.test(this.firstName))
      throw new BadRequestException(UserErrorMessages.onlyLetters('FirstName'));

    if (!UserDefinitions.REGEX.NAME.test(this.lastName))
      throw new BadRequestException(UserErrorMessages.onlyLetters('LastName'));

    if (!UserDefinitions.REGEX.USERNAME.test(this.username))
      throw new BadRequestException(UserErrorMessages.alphaNumeric('Username'));
  }
}
