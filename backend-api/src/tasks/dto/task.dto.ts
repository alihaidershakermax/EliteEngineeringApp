import { IsString, IsNotEmpty, IsOptional, IsNumber, IsDateString, IsIn } from 'class-validator';

export class CreateTaskDto {
  @IsNotEmpty({ message: 'عنوان المهمة مطلوب' })
  @IsString()
  title: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsNotEmpty({ message: 'الأولوية مطلوبة' })
  @IsIn(['عالية', 'متوسطة', 'منخفضة'], { message: 'الأولوية يجب أن تكون: عالية، متوسطة، أو منخفضة' })
  priority: string;

  @IsNotEmpty({ message: 'تاريخ الاستحقاق مطلوب' })
  @IsDateString()
  dueDate: string;

  @IsOptional()
  @IsNumber()
  progress?: number;

  @IsOptional()
  @IsString()
  category?: string;
}

export class UpdateTaskDto {
  @IsOptional()
  @IsString()
  title?: string;

  @IsOptional()
  @IsString()
  description?: string;

  @IsOptional()
  @IsIn(['عالية', 'متوسطة', 'منخفضة'])
  priority?: string;

  @IsOptional()
  @IsDateString()
  dueDate?: string;

  @IsOptional()
  @IsNumber()
  progress?: number;

  @IsOptional()
  @IsIn(['نشطة', 'مكتملة', 'متأخرة'])
  status?: string;
}
