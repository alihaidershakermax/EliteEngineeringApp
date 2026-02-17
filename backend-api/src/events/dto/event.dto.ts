import { IsString, IsNotEmpty, IsOptional, IsDateString } from 'class-validator';

export class CreateEventDto {
  @IsNotEmpty({ message: 'عنوان الفعالية مطلوب' })
  @IsString()
  title: string;

  @IsNotEmpty({ message: 'وصف الفعالية مطلوب' })
  @IsString()
  description: string;

  @IsNotEmpty({ message: 'تاريخ الفعالية مطلوب' })
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
  image?: string;

  @IsOptional()
  @IsString()
  organizer?: string;
}
