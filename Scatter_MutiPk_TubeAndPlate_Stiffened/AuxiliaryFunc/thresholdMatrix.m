function result = thresholdMatrix(matrix, Lim_0)
    % 获取矩阵的大小
    [rows, cols] = size(matrix);
    
    % 创建一个与原始矩阵相同大小的复数零矩阵
    result = complex(zeros(rows, cols), zeros(rows, cols));
    
    % 遍历矩阵中的每个元素
    for i = 1:rows
        for j = 1:cols
            % 获取当前元素的实部和虚部
            realPart = real(matrix(i, j));
            imagPart = imag(matrix(i, j));
            
            % 如果实部的绝对值小于 Lim_0，则将实部置为 0
            if abs(realPart) < Lim_0
                realPart = 0;
            end
            
            % 如果虚部的绝对值小于 Lim_0，则将虚部置为 0
            if abs(imagPart) < Lim_0
                imagPart = 0;
            end
            
            % 更新结果矩阵中的元素
            result(i, j) = complex(realPart, imagPart);
        end
    end
end

