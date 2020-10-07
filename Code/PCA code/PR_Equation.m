function data = PR_Mapping(z_score)
    data = .5 * (erf(z_score / 2 ^ .5) + 1);
end