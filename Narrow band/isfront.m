function front = isfront( phi )%����һ����ֵ���󣬾����ÿ�����ص��ֵ��ʾ��ǰ���Ƿ�Ϊ�߽��
% ISFRONT Determine whether a pixel is a front point
%    ISFRONT( phi ) return binary matrix whose value at each pixel
%    represents whether the corresponding pixel in phi is a front
%    point or not.

% grab the size of phi
[ n, m ] = size( phi );

% create an boolean matrix whose value at each pixel is 0 or 1
% depending on whether that pixel is a front point or not
front = zeros( size( phi ) );

% A piecewise(�ֶ�) linear approximation to the front is contructed by
% checking each pixels neighbour. Do not check pixels on border.
for i = 2 : n - 1;
  for j = 2 : m - 1;

    % if there is a sign change then we have a front point
    %�ж�(i,j),(i+1,j),(i,j+1)��(i+1,j+1)�ĸ������Ƿ�����б߽��
    %****ע�⣺�����Ԫ�ص�������Сֵ����ʽΪ��max(max(matrix))��min(min(matrix))
    maxVal = max( max( phi( i:i+1, j:j+1 ) ) );%�ҳ��ĸ����е����ֵ
    minVal = min( min( phi( i:i+1, j:j+1 ) ) );%�ҳ��ĸ����е���Сֵ
    front( i, j ) = ( ( maxVal > 0 ) & ( minVal < 0 ) ) | phi( i, j ) == 0;
    %���ĸ����е�������Сֵ��Ż��ߵ�ǰ��(i,j)ֵΪ�㣬������б߽��

  end
end