using System;

namespace TalesOfAForthGrade.Api.Entities
{
    public record Absence{
        public Guid Id { get; init; }
        public Guid Student { get; init; }
        public Guid Subject { get; init; }
        public bool excused { get; init; }
        public string motivation { get; init; }
        public DateTimeOffset Date { get; init; }
    }
}