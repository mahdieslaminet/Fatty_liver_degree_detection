% 1. تحميل نموذج AlexNet (تأكد من تثبيت الحزمة أولاً)
if ~exist('alexnet', 'file')
    error('الحزمة غير مثبتة! الرجاء تثبيت Deep Learning Toolbox Model for AlexNet Network من Add-Ons');
else
    net = alexnet;
end

% 2. اختيار الصورة بشكل تفاعلي
[filename, pathname] = uigetfile(...
    {'*.jpg;*.jpeg;*.png;*.bmp', 'ملفات الصور (*.jpg, *.jpeg, *.png, *.bmp)'},...
    'اختر صورة للتصنيف');

if isequal(filename, 0)
    error('لم يتم اختيار أي صورة');
end

% 3. قراءة الصورة
try
    img_path = fullfile(pathname, filename);
    img = imread(img_path);
catch ME
    error(['حدث خطأ أثناء قراءة الصورة: ' ME.message]);
end

% 4. معالجة الصورة
try
    % التحقق من عدد القنوات
    if size(img, 3) == 1 % إذا كانت صورة رمادية
        img = repmat(img, [1 1 3]); % تحويل إلى RGB
    elseif size(img, 3) == 4 % إذا كان بها قناة ألفا
        img = img(:, :, 1:3); % تجاهل قناة ألفا
    end
    
    % تغيير الحجم إلى 227x227 كما يتطلب AlexNet
    img = imresize(img, [227 227]);
catch
    error('حدث خطأ أثناء معالجة الصورة');
end

% 5. تصنيف الصورة وعرض النتائج
try
    label = classify(net, img);
    figure;
    imshow(img);
    title(['التصنيف: ' char(label)], 'FontSize', 14, 'Color', 'blue');
    disp(['تم تصنيف الصورة على أنها: ' char(label)]);
catch
    error('حدث خطأ أثناء التصنيف');
end