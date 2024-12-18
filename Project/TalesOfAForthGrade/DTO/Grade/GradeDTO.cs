using System;
using MongoDB.Driver;

namespace TalesOfAForthGrade.DTO.Grade
{
    public record GradeDTO{
        public Guid Id { get; init; }
        public Guid Student { get; init; }
        public Guid Subject { get; init; }
        public int Value { get; init; }
        public DateTimeOffset Date { get; init; }
    }
}