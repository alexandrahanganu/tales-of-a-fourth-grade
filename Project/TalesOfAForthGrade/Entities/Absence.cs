using System;
using MongoDB.Driver;

namespace TalesOfAForthGrade.Entities
{
    public record Absence{
        public Guid Id { get; init; }
        public Guid Student { get; init; }
        public Guid Subject { get; init; }
        public bool excused { get; init; }
        public string motivation { get; init; }
    }
}