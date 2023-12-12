using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities.Attributes;

namespace Domain.Entities
{
    [TableAttribute("projects")]
    public class Project
    {
        public int Id { get; set; }

        public string? Title { get; set; }

        public DateTime? StartDate { get; set; }

        public DateTime? EndDate { get; set; }

        public string? Description { get; set; }

        public int TeamManagerId { get; set; }

        public string? Status { get; set; }

        public override string ToString()
        {
            return Id + " " + Title + " " + StartDate + " " + TeamManagerId;
        }
        public Project()
        {

        }
    }
}
