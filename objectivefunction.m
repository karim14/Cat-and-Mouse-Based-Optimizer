function z = objectivefunction(x)
z = sum(abs(x(:)))+prod(abs(x(:)));
end