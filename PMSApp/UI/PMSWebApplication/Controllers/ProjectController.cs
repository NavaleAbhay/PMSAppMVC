using System.Diagnostics;
using Domain.Entities;
using Microsoft.AspNetCore.Mvc;
using Application.Services.Interfaces;
using PMSWebApplication.Models;

namespace PMSWebApplication.Controllers;

public class ProjectController : Controller
{
    private readonly IProjectService _projectService;

    public ProjectController(IProjectService projectService)
    {
        _projectService = projectService;
    }

    public IActionResult Index()
    {
        return View();
    }

    public async Task<ActionResult> ProjectList()
    {
        IEnumerable<Project> projects = await _projectService.GetAllProjects();
        return PartialView("ProjectList", projects);
    }
}
