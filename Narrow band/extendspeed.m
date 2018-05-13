function speed = extendspeed( speed, front )%��չ�ٶȵ�ȫ���ڵķǱ߽�㣨��խ����
% EXTENDSPEED Extends speed to non-front points
%    EXTENDSPEED( speed, front ) Extends speed function to
%    all pixels in 'speed'. For each non-front pixel, its speed is
%    the same as the speed of the closest front pixel.

% grab the size of the speed matrix
[ m, n ] = size( speed );

% grab the total number of front points
n_front = size( front, 1 );

% for every pixel�ҳ���(i,j)�ڱ߽����ϵ������P������P����ٶȸ�����(i,j)
for i = 1 : m;
  for j = 1 : n;

    % find the front pixel it is closest to
    closest_dist = inf;
    closest_pt = front( 1, : );
    for k = 1 : n_front;
      dist = sum( ( front( k, : ) - [ i, j ] ).^2 );
      if( dist < closest_dist )
	closest_dist = dist;
	closest_pt = front( k, : );%�ѵڣ���㣬������㣬��ֵ��closest_pt.closest_pt(1)��ʾ��ģ�����
      end;
    end;

    % and copy its speed
    speed( i, j ) = speed( closest_pt( 1 ), closest_pt( 2 ) );
  end;
end;
