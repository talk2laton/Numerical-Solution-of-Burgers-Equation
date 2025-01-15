Burgers' Equation: A Nonlinear Challenge
Burgers' equation is a fundamental partial differential equation (PDE) that arises in various fields of physics and engineering, including fluid mechanics, traffic flow, and acoustics. It's a simplified model that captures the interplay between convection (transport) and diffusion. 


The Equation:
In its general form, Burgers' equation is expressed as:

$$\frac{\partial u}{\partial t} + u \frac{\partial u}{\partial x} = ν \frac{\partial^2 u}{\partial x^2} $$

where:
> $u$: The dependent variable (often representing velocity or density)

> $t$: Time

> $x$: Spatial coordinate

> $\nu$: Viscosity coefficient (a constant) 

Key Features:
> Nonlinearity: The term $u \frac{\partial u}{\partial x} $ introduces nonlinearity, making the equation challenging to solve analytically.

> Convection and Diffusion: The equation balances convective effects (represented by the nonlinear term) and diffusive effects (represented by the second-order derivative term).

> Viscosity: The viscosity coefficient (ν) controls the strength of diffusion. When ν = 0, the equation becomes the inviscid Burgers' equation, which exhibits shock wave formation. 

Applications:
>  Fluid Mechanics: Models the behavior of viscous fluids, including shock waves and turbulence.

>  Traffic Flow: Describes the dynamics of vehicular traffic, capturing phenomena like traffic jams and wave propagation.

>  Gas Dynamics: Used to study the flow of gases, particularly in situations involving shock waves.

>  Noise Propagation: Models the propagation of sound waves in certain media.

Analytical Solutions:
>   Inviscid Burgers' Equation (ν = 0): Can be solved using the method of characteristics.

>   Viscous Burgers' Equation (ν > 0): Can be transformed into the heat equation using the Cole-Hopf transformation, allowing for analytical solutions in some cases.

Numerical Methods:
For more complex cases, numerical methods are often employed, such as:
>   Finite Difference Methods: Discretize the equation on a grid and approximate derivatives using finite differences.

>   Finite Element Methods: Divide the domain into elements and approximate the solution using piecewise polynomials.

>   Spectral Methods: Represent the solution as a sum of basis functions (e.g., Fourier series) and solve the resulting system of equations. 

Challenges and Significance:
  Burgers' equation, despite its apparent simplicity, presents significant challenges due to its nonlinear nature. It serves as a valuable model for understanding more complex phenomena in fluid dynamics and other fields. Studying Burgers' equation provides insights into the behavior of nonlinear systems and the development of numerical methods for solving such problems.

Now we look at the numerical solutions using finite difference.
With finite difference, we can approach it in 2 ways. 
> 1. We can use discretize only the spartial component and perform numerical intergation over temporal variable (this is called method of lines)

> 2. We can perform full descritzation over spartial and temporal variable and then solve the system of nonlinear algebraic equations. 

We will look at the second method. 

$$\frac{u_i^{n+1} - u_i^{n}}{\Delta t} + u_{i}^{n+1} \frac{u_{i+1}^{n+1} - u_{i-1}^{n+1}}{2\Delta x} = ν \frac{u_{i-1}^{n+1} - 2u_{i}^{n+1} + u_{i-1}^{n+1}}{\partial x^2} $$

This is now expressed in the form $F(u_{i}^{n+1}) = 0$ so that $u_{i}^{n+1}$ can now be solved for using newton's method such as Fsolve in matlab


$$u_i^{n+1} - u_i^{n} +  \Delta t \left(u_{i}^{n+1} \frac{u_{i+1}^{n+1} - u_{i-1}^{n+1}}{2\Delta x} - ν \frac{u_{i-1}^{n+1} - 2u_{i}^{n+1} + u_{i-1}^{n+1}}{\partial x^2}\right)  = 0$$
