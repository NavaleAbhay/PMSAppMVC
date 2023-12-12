using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Domain.Entities;
namespace Service.Interfaces
{
    public interface IProjectService
    {
        Task<IEnumerable<Project>> GetAllProjects();
        Task<Project> GetProjectById(int id);
        Task<IEnumerable<Project>> GetProjectsById(int id);
        Task Add(Project entity);
        Task Delete(int id);
        Task Update(Project entity);
    }
}
