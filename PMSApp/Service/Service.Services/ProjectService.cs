using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using  Service.Interfaces;
using Domain.Entities;
using Infrastructure.Repositories.Interfaces;
namespace Service.Services
{
    public class ProjectService : IProjectService
    {
        private readonly IProjectRepository _projectRepository;

        public ProjectService(IProjectRepository projectRepository)
        {
            _projectRepository = projectRepository;
        }

        public async Task<IEnumerable<Project>> GetAllProjects()
        {
            return await _projectRepository.FindAll();
        }

        public  Task<Project> GetProjectById(int id)
        {
            return _projectRepository.FindById(id);
        }

        public Task<IEnumerable<Project>> GetProjectsById(int id)
        {
            return _projectRepository.FindAllById(id);
        }

        public Task Add(Project entity)
        {
            return _projectRepository.Add(entity);
        }

        public Task Delete(int id)
        {
            return _projectRepository.Delete(id);
        }

        public Task Update(Project entity)
        {
            return _projectRepository.Update(entity);
        }
    }
}
