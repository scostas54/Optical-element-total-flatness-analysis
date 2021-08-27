# Optical-element-total-flatness-analysis
This MATLAB program that I developed as my final project during my degree in mechanical engenieering, allows to determine the flatness of optical elements such as mirrors or reflectors. Starting from four phase distributions, it gives as a result the deviations with respect to an ideal plane for each surface.

Many of the different techniques that make up Optical Metrology provide information on the quantities being measured through phase differences encoded in turn in the form of spatial intensity variations, the so-called fringe patterns. The decoding process that provides the spatial distribution of the phase (phase map) using one or more of these fringe patterns is called "Phase Evaluation".

There are different phase evaluation methods, most of them assume a sinusoidal dependence between intensity and phase. In a series of these methods, the so-called Phase Shift Algorithms or PSAs are used as a tool to obtain the phase through an inverse trigonometric function whose argument is a combination of intensity values shifted in phase, obtained from one or various stripe patterns. (Sánchez, 2014)

In our case we use one of these algorithms, the so-called Schwider-Hariharan. It starts with five images, each is a pattern of stripes in which the phase is shifted 90º between each image, the intensity values of those images (patterns) are combined and with the application of this algorithm the corresponding phase map is obtained. The phase obtained with these methods, because we are using an arcotang function, appears in modulo 2π, in particular it takes values on the range between -π and π, which makes the neccesary to apply the process called unwrapping, in which the phase jumps are recomposed.

By applying unwrapping to the phase maps, a continuous phase is obtained that will keep a linear relationship with the magnitude to be measured (distance difference between both arms of the interferometer in our case), this allows us to work in Matlab using these maps as matrices.

**For more detailed information please send me an email.**
