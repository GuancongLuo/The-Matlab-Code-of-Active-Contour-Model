function phi = initphi( imsize, center, radius, isinside )
% INITPHI Initialize the phi funcion
%    INITPHI( center, radius ) initializes the zero level level-set
%    of the phi function by the circle with the given center (x, y)
%    and radius. The size of phi is given by 'imsize'.
%��һ��Բ����ʼ��ˮƽ������phi����ˮƽ��

% grab the requested size of phi
m = imsize( 1 ); n = imsize( 2 );%imsize=size(phi),imsize�൱��һ������,imsize(1)����ͼ���������

% create a zero matrix
phi = zeros( imsize );

% go over each pixel
for i = 1 : m;
  for j = 1 : n;

    % get the sum of squares distance of the pixel from the center
    % of the circle��
    distance = sqrt( sum( ( center - [ i, j ] ).^2 ) );
    %distanceΪ������ֵΪ��(i,j)�����ĵ�center�ľ���ƽ��

    % set phi to be the signed distance from the pixel to the
    % circle's boundary, where the distance is positive for pixels
    % outside the boundary and negative for pixels inside the
    % boundary
    phi( i, j ) = distance - radius;

    if( isinside == 0 )
      phi( i, j ) = -phi( i, j );
    end

  end
end
