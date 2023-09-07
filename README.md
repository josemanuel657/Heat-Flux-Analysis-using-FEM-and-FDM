# Heat Flux Analysis

Hello there! Welcome to the Heat Flux Analysis project by Jose Manuel, an undergraduate student at Worcester Polytechnic Institute (WPI). This project was carried out during the Summer of 2023 as part of the EREE program at WPI, in collaboration with Professor Caceres.

This project focuses on simulating the flux of heat in a square room section under various boundary conditions using the Heat Equation. To simulate a partial differential equation with no analytical solution, we have employed MATLAB, implementing a vertex approach based on the finite element method (FEM) for space discretization and the finite differences method for time discretization. The vectorization of matrices and the efficient methodology discussed in the analysis PDF make this simulation both mathematically reliable and efficient.


The main components of this project include:

- Triangular Mesher: Responsible for generating the mesh necessary for spatial discretization.

- Recursive Equation Simulator: This module simulates the heat flux by solving the Heat Equation using the finite element and finite differences methods.

- Boundary Condition Files: A set of predefined boundary conditions that can be applied to the simulation.

- Explanatory Poster: An informative poster summarizing the key aspects of the project.

- In-Depth Analysis Paper: A detailed research paper discussing the optimization of the finite differences method for time discretization.


To run the simulation, follow these steps:

1) Open your MATLAB terminal/command prompt.
2) Navigate to the project directory.
3)Type the following command, replacing #subdivisions with the desired number of subdivisions:
  $ Heat(#subdivisions)
  For example, to run the simulation with 12 subdivisions:

For more detailed information about the project, the mathematical methodologies used, and the results obtained, please refer to the analysis PDF and the research paper included in this repository.

If you have any questions or need further assistance, feel free to contact me at jjimenez1@wpi.edu
