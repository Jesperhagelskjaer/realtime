function [] = digilinxFiltering(par)


mConstantA = exp((-2 * pi * par.filtering(1))/sampleFrequency);
mConstantB = 1 - mConstantA;
mCurrentState = 0;
 
Then as each new sample is received the following is processed.
mCurrentState = (mConstantB * NewSample) + (mConstantA * mCurrentState);
NewSample = (int)(NewSample - mCurrentState);

end

