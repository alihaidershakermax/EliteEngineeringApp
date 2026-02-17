import { IsString, IsNotEmpty, IsOptional } from 'class-validator';

export class CreateAnnouncementDto {
  @IsNotEmpty({ message: 'عنوان الإعلان مطلوب' })
  @IsString()
  title: string;

  @IsNotEmpty({ message: 'محتوى الإعلان مطلوب' })
  @IsString()
  content: string;

  @IsOptional()
  @IsString()
  type?: string;

  @IsOptional()
  @IsString()
  image?: string;

  @IsOptional()
  @IsString()
  author?: string;
}
