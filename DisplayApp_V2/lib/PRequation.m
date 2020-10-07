%Convert raw data into PR value by equation.
function data = PRequation(rawData)
    z_score = zscore(rawData);
    data = .5 * (erf(z_score / 2 ^ .5) + 1);
end