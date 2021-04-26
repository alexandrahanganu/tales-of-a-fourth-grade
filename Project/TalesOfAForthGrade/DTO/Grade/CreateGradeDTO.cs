using System;

namespace TalesOfAForthGrade.DTO.Grade
{
    public record CreateGradeDTO{
        public Guid Student { get; init; }
        public int Value { get; init; }
        public DateTimeOffset Date { get; init; }
    }
}