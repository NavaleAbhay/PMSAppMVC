using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Interfaces;
using Domain.Entities;
namespace Infrastructure.Repositories.Interfaces
{
    public interface IProjectRepository : IRepository<Project>
    {
    }
} 