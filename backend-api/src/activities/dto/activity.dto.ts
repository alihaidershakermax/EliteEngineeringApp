import { IsString, IsNotEmpty, IsOptional, IsNumber, IsDateString } from 'class-validator';

export class CreateActivityDto {
  @IsNotEmpty({ message: 'عنوان النشاط مطلوب' })
  @IsString()
  title: string;

  @IsNotEmpty({ message: 'وصف النشاط مطلوب' })
  @IsString()
  description: string;

  @IsNotEmpty({ message: 'نوع النشاط مطلوب' })
  @IsString()
  category: string;

  @IsNotEmpty({ message: 'تاريخ النشاط مطلوب' })
  @IsDateString()
  date: string;

  @IsOptional()
  @IsString()
  time?: string;

  @IsOptional()
  @IsString()
  location?: string;

  @IsOptional()
  @IsString()
  instructor?: string;

  @IsOptional()
  @IsNumber()
  maxParticipants?: number;

  @IsOptional()
  @IsString()
  image?: string;
}

export class RegisterActivityDto {
  @IsOptional()
  @IsString()
  notes?: string;
}
