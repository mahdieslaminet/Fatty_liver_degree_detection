IMG1 = SQUARE(IMG, x1, y1, 150);
IMG2 = SQUARE(IMG, x2, y2, 150);
IMG3 = SQUARE(IMG, x3, y3, 150);
IMG4 = SQUARE(IMG, x4, y4, 150);
IMG5 = SQUARE(IMG, x5, y5, 150);
IMG6 = SQUARE(IMG, x6, y6, 150);
IMG7 = SQUARE(IMG, x7, y7, 150);

IMG8 = SQUARE(IMG1, x2, y2, 150);
IMG8 = SQUARE(IMG8, x3, y3, 150);
IMG8 = SQUARE(IMG8, x4, y4, 150);
IMG8 = SQUARE(IMG8, x5, y5, 150);
IMG8 = SQUARE(IMG8, x6, y6, 150);
IMG8 = SQUARE(IMG8, x7, y7, 150);


figure
subplot(331);imshow(IMG8)
subplot(332);imshow(IMG1)
subplot(333);imshow(IMG2)
subplot(334);imshow(IMG3)
subplot(335);imshow(IMG4)
subplot(336);imshow(IMG5)
subplot(337);imshow(IMG6)
subplot(338);imshow(IMG7)

figure
subplot(331);imshow(IMG8)
subplot(332);imshow(roi1)
subplot(333);imshow(roi2)
subplot(334);imshow(roi3)
subplot(335);imshow(roi4)
subplot(336);imshow(roi5)
subplot(337);imshow(roi6)
subplot(338);imshow(roi7)