function speed = extendspeedband( speed, front, band )
% EXTENDSPEEDBAND Extends speed to non-front points��չ�ٶȵ�խ���ڵķǱ�Ե��
%    EXTENDSPEEDBAND( speed, front ) Extends speed function to
%    all pixels in a narrow band around 'front' given by the
%    indices in 'band'. For each band pixel, its speed is
%    the same as the speed of the closest front��pixel.
%    ��չ�ٶȺ�����խ���ڵ����е㣬ÿ��խ���ڵ���ٶȺ;���������ı�Ե�ϵĵ���ٶ���ͬ

% grab the size of the speed matrix
[ m, n ] = size( speed );

% grab the total number of front and band points
n_front = size( front, 1 );%��Ե�����Ŀ
n_band  = size( band, 1 );%խ���ڵ����Ŀ

% for every pixel in the band
for ii = 1 : n_band;

  % grab the coordinates of the band pixel���խ���ڵ����������ֵ
  i = band( ii, 1 ); j = band( ii, 2 );

  % find the front pixel it is closest to�ҵ�����㣨i,j������ı�Ե��
  closest_dist = inf;
  closest_point = front( 1, : );%front(k,:)���صڣ�����x,y����ֵ
  for kk = 1 : n_front;
    dist = sum( ( front( kk, : ) - [ i, j ] ).^2 );
    if( dist < closest_dist )
      closest_dist = dist;
      closest_point = front( kk, : );
    end;
  end;

  % and copy its speed
  speed( i, j ) = speed( closest_point( 1 ), closest_point( 2 ) );
  %closest_point(1)����x���������ֵ,closest_point(2)���أ���������ֵ
end;
