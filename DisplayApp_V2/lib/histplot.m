function histplot(data, bins)
    pd_Ker = fitdist(data, 'kernel');
    pd_Norm = fitdist(data, 'normal');
    t = 0:10:100;
    pdf_Ker = pdf(pd_Ker, t);
    pdf_Norm = pdf(pd_Norm, t);
    histogram(data, bins, 'Normalization', 'pdf');
    line(t, pdf_Ker, 'LineStyle', '--', 'Color', 'r');
    line(t, pdf_Norm, 'LineStyle', '-', 'Color', 'b');
    legend('Data', 'Kernel Distribution', 'Normal Distribution','Location','northwest');
    xlabel('Bins for student scores');
    title('Course score distribution');
end