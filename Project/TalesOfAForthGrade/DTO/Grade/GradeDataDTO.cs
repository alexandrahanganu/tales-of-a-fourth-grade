using System;

namespace TalesOfAForthGrade.DTO.Grade
{
    public record GradeDataDTO{
        public string Subject { get; init; }
        public int Value { get; init; }
        public DateTimeOffset Date { get; init; }
    }
}