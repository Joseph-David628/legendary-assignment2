myFolder = '/Users/joseph/Documents/MATLAB/CroppedYale';
myFolder2 = '/Users/joseph/Documents/MATLAB/yalefaces_uncropped/yalefaces';

filePattern = fullfile(myFolder, '**/*.pgm');
theFiles = dir(filePattern);

filePattern2 = fullfile(myFolder2, 'subject*');
theFiles2 = dir(filePattern2);

%creating matrix A where columns are the reshaped cropped images
A = zeros(120*80, length(theFiles));

for k = 1 : length(theFiles)
    baseFileName = theFiles(k).name;
    fullFileName = fullfile(theFiles(k).folder, baseFileName);
    A(:,k) = reshape(imresize(double(imread(fullFileName)), [120 80]), 120*80, 1);
end

%SVD analysis
[U, S, V] = svd(A);

figure(1)
subplot(1,3,1), face1 = reshape(U(:,1), 120,80); pcolor(flipud(face1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', [])
subplot(1,3,2), face1 = reshape(U(:,2), 120,80); pcolor(flipud(face1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', [])
subplot(1,3,3), face1 = reshape(U(:,3), 120,80); pcolor(flipud(face1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', [])

%calcularing how many nonzero singular values A has.
rank = 0;
for i = 1 : 2414
    if S(i,i) ~= 0
        rank = rank + 1;
    end
end

rank

%reconstructing faces using 20, 50, and 100 eigenfaces, respectively. 
proj1 = A(:,1)' * U(:,1:20);
recon1 = U(:,1:20) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(2)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);

proj1 = A(:,1)' * U(:,1:50);
recon1 = U(:,1:50) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(3)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);

proj1 = A(:,1)' * U(:,1:100);
recon1 = U(:,1:100) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(4)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);


%repeat process with uncropped images
B = zeros(120*80, length(theFiles2));

for k = 1 : length(theFiles2)
    baseFileName = theFiles2(k).name;
    fullFileName = fullfile(theFiles2(k).folder, baseFileName);
    B(:,k) = reshape(imresize(double(imread(fullFileName)), [120 80]), 120*80, 1);
end

[U2, S2, V2] = svd(B);

%reconstructing an uncropped face (first column of image matrix) using 20, 50, and 100 eigenfaces, respectively. 
proj1 = B(:,1)' * U2(:,1:20);
recon1 = U2(:,1:20) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(5)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);

proj1 = B(:,1)' * U2(:,1:50);
recon1 = U2(:,1:50) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(6)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);

proj1 = B(:,1)' * U2(:,1:100);
recon1 = U2(:,1:100) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(7)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);

proj1 = B(:,1)' * U2(:,1:165);
recon1 = U2(:,1:165) * proj1'; rec1 = reshape(recon1, 120, 80);
figure(8)
subplot(1,1,1), pcolor(flipud(rec1)), shading interp, colormap(gray), set(gca, 'Xtick', [], 'Ytick', []);

%plotting the singular values of cropped and uncropped matrices in order to
%compare
x = zeros([1 165]);
y = zeros([1 165]);
for k = 1 : 165
    x(k) = k;
    y(k) = S(k,k);
end

figure(9)
bar(x,y)

x = zeros([1 165]);
y = zeros([1 65]);
for k = 1 : 165
    x(k) = k;
    y(k) = S2(k,k);
end

figure(10)
bar(x,y)