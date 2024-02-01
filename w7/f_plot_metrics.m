%% Function for plotting the metrics

function f_plot_metrics(compression_rates, MSE, RMSE, PSNR)
    figure;
    subplot(3,1,1);
    plot(compression_rates, MSE);
    title('MSE vs Compression Rate');
    xlabel('Compression Rate');
    ylabel('MSE');

    subplot(3,1,2);
    plot(compression_rates, RMSE);
    title('RMSE vs Compression Rate');
    xlabel('Compression Rate');
    ylabel('RMSE');

    subplot(3,1,3);
    plot(compression_rates, PSNR);
    title('PSNR vs Compression Rate');
    xlabel('Compression Rate');
    ylabel('PSNR');
end