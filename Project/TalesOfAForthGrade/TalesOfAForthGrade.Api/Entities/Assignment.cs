using System;

namespace TalesOfAForthGrade.Api.Entities
{
    public record Assignment{
        public Guid Id { get; init; }
        public Guid Student { get; init; }
        public Guid Subject { get; init; }
        public bool Done {get; init;}
        public DateTimeOffset DateFrom { get; init; }
        public DateTimeOffset DateDue { get; init; }
    }
}