import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(const FlutterWidgetCatalog());
}

class FlutterWidgetCatalog extends StatefulWidget {
  const FlutterWidgetCatalog({super.key});

  @override
  State<FlutterWidgetCatalog> createState() => _FlutterWidgetCatalogState();
}

class _FlutterWidgetCatalogState extends State<FlutterWidgetCatalog> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Widget Catalog",
      home: Scaffold(
        appBar: AppBar(title: const Text("Flutter Widget Catalog")),
        body: LongPressDraggableExample(),
      ),
    );
  }
}

class ReorderableListViewExample extends StatefulWidget {
  @override
  _ReorderableListViewExampleState createState() =>
      _ReorderableListViewExampleState();
}

class _ReorderableListViewExampleState
    extends State<ReorderableListViewExample> {
  final List<String> items = List.generate(5, (index) => 'Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ReorderableListView Example")),
      body: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex -= 1;
            final item = items.removeAt(oldIndex);
            items.insert(newIndex, item);
          });
        },
        children: [
          for (final item in items)
            ListTile(
              key: ValueKey(item),
              title: Text(item),
              leading: Icon(Icons.drag_handle),
            ),
        ],
      ),
    );
  }
}

class CustomPaintExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("CustomPaint Example")),
      body: Center(
        child: CustomPaint(size: Size(200, 200), painter: CirclePainter()),
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class FractionallySizedBoxExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FractionallySizedBox Example")),
      body: Center(
        child: Container(
          color: Colors.grey.shade300,
          width: 300,
          height: 300,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            heightFactor: 0.3,
            alignment: Alignment.bottomRight,
            child: Container(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}

class ShaderMaskExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("ShaderMask Example")),
      body: Center(
        child: ShaderMask(
          shaderCallback: (rect) {
            return LinearGradient(
              colors: [Colors.red, Colors.yellow, Colors.green],
            ).createShader(rect);
          },
          blendMode: BlendMode.srcIn,
          child: Text(
            "Flutter ShaderMask",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class LongPressDraggableExample extends StatefulWidget {
  const LongPressDraggableExample({super.key});

  @override
  State<LongPressDraggableExample> createState() =>
      _LongPressDraggableExampleState();
}

class _LongPressDraggableExampleState extends State<LongPressDraggableExample> {
  Color _caughtColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("LongPressDraggable Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("اضغط مطولًا على المربع واسحبه للأسفل"),
          const SizedBox(height: 20),

          LongPressDraggable<Color>(
            data: Colors.blue,
            feedback: Container(
              width: 100,
              height: 100,
              color: Colors.blue.withOpacity(0.7),
              child: const Center(
                child: Text("Dragging", style: TextStyle(color: Colors.white)),
              ),
            ),
            child: Container(
              width: 100,
              height: 100,
              color: Colors.blue,
              child: const Center(
                child: Text("Box", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),

          const SizedBox(height: 80),

          DragTarget<Color>(
            onAccept: (color) {
              setState(() {
                _caughtColor = color;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 120,
                height: 120,
                color: _caughtColor,
                child: const Center(
                  child: Text(
                    "Target",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class InteractiveViewerExample extends StatelessWidget {
  const InteractiveViewerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("InteractiveViewer Example")),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true,
          scaleEnabled: true,
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.network(
            "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class IgnorePointerExample extends StatefulWidget {
  const IgnorePointerExample({super.key});

  @override
  State<IgnorePointerExample> createState() => _IgnorePointerExampleState();
}

class _IgnorePointerExampleState extends State<IgnorePointerExample> {
  bool _ignoring = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("IgnorePointer Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IgnorePointer(
              ignoring: _ignoring, // لو true الويدجت هيتجاهل أي لمسة
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Button Pressed!")),
                  );
                },
                child: const Text("Click Me"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _ignoring = !_ignoring;
                });
              },
              child: Text(_ignoring ? "Enable Button" : "Disable Button"),
            ),
          ],
        ),
      ),
    );
  }
}

class DraggableScrollableSheetExample extends StatelessWidget {
  const DraggableScrollableSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DraggableScrollableSheet Example")),
      body: Stack(
        children: [
          const Center(
            child: Text("Main Content", style: TextStyle(fontSize: 22)),
          ),

          DraggableScrollableSheet(
            initialChildSize: 0.2,
            minChildSize: 0.1,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.star, color: Colors.white),
                      title: Text(
                        "Item ${index + 1}",
                        style: const TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DraggableExample extends StatefulWidget {
  const DraggableExample({super.key});

  @override
  State<DraggableExample> createState() => _DraggableExampleState();
}

class _DraggableExampleState extends State<DraggableExample> {
  Offset position = const Offset(100, 100);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Draggable Example")),
      body: Stack(
        children: [
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Draggable(
              feedback: Container(
                width: 100,
                height: 100,
                color: Colors.blue.withOpacity(0.7),
                child: const Center(
                  child: Text(
                    "Dragging",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              childWhenDragging: Container(
                width: 100,
                height: 100,
                color: Colors.grey,
                child: const Center(child: Text("Original")),
              ),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(
                  child: Text("Box", style: TextStyle(color: Colors.white)),
                ),
              ),
              onDragEnd: (details) {
                setState(() {
                  position = details.offset;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DragTargetExample extends StatefulWidget {
  const DragTargetExample({super.key});

  @override
  State<DragTargetExample> createState() => _DragTargetExampleState();
}

class _DragTargetExampleState extends State<DragTargetExample> {
  Color _targetColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DragTarget Example")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Drag the box into the target below"),
          const SizedBox(height: 30),

          // عنصر يمكن سحبه
          Draggable<Color>(
            data: Colors.blue,
            feedback: Container(
              width: 80,
              height: 80,
              color: Colors.blue.withOpacity(0.7),
              child: const Center(
                child: Text("Drag", style: TextStyle(color: Colors.white)),
              ),
            ),
            childWhenDragging: Container(
              width: 80,
              height: 80,
              color: Colors.grey,
              child: const Center(child: Text("Empty")),
            ),
            child: Container(
              width: 80,
              height: 80,
              color: Colors.blue,
              child: const Center(
                child: Text("Box", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),

          const SizedBox(height: 60),

          // الهدف اللي هنرمي فيه العنصر
          DragTarget<Color>(
            onAccept: (color) {
              setState(() {
                _targetColor = color;
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                width: 120,
                height: 120,
                color: _targetColor,
                child: const Center(
                  child: Text(
                    "Target",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class DismissibleExample extends StatefulWidget {
  const DismissibleExample({super.key});

  @override
  State<DismissibleExample> createState() => _DismissibleExampleState();
}

class _DismissibleExampleState extends State<DismissibleExample> {
  final List<String> items = List.generate(5, (index) => "Item ${index + 1}");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dismissible Example")),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Dismissible(
            key: Key(item),
            direction: DismissDirection.endToStart,
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (direction) {
              setState(() {
                items.removeAt(index);
              });

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text("$item dismissed")));
            },
            child: ListTile(title: Text(item)),
          );
        },
      ),
    );
  }
}

class AbsorbPointerExample extends StatefulWidget {
  const AbsorbPointerExample({super.key});

  @override
  State<AbsorbPointerExample> createState() => _AbsorbPointerExampleState();
}

class _AbsorbPointerExampleState extends State<AbsorbPointerExample> {
  bool _absorbing = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AbsorbPointer Example")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AbsorbPointer(
              absorbing: _absorbing, // لو true الزرار مش هيستجيب
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Button Pressed!")),
                  );
                },
                child: const Text("Click Me"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _absorbing = !_absorbing;
                });
              },
              child: Text(_absorbing ? "Enable Button" : "Disable Button"),
            ),
          ],
        ),
      ),
    );
  }
}

class SlideTransitionExample extends StatefulWidget {
  const SlideTransitionExample({super.key});

  @override
  State<SlideTransitionExample> createState() => _SlideTransitionExampleState();
}

class _SlideTransitionExampleState extends State<SlideTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SlideTransition Example")),
      body: Center(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Container(
            width: 200,
            height: 100,
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text(
              "Hello Flutter!",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}

class CupertinoDatePickerExample extends StatefulWidget {
  const CupertinoDatePickerExample({super.key});

  @override
  State<CupertinoDatePickerExample> createState() =>
      _CupertinoDatePickerExampleState();
}

class _CupertinoDatePickerExampleState
    extends State<CupertinoDatePickerExample> {
  DateTime selectedDate = DateTime.now();

  void _showDatePicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder:
          (_) => Container(
            height: 300,
            color: CupertinoColors.systemBackground,
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: selectedDate,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        selectedDate = newDate;
                      });
                    },
                  ),
                ),
                CupertinoButton(
                  child: const Text("Done"),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("CupertinoDatePicker Example"),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Selected Date:\n${selectedDate.toLocal()}",
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CupertinoButton.filled(
                child: const Text("Pick a Date"),
                onPressed: () => _showDatePicker(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoContextMenuActionExample extends StatelessWidget {
  const CupertinoContextMenuActionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("CupertinoContextMenu & Action"),
        ),
        child: SafeArea(
          child: Center(
            child: CupertinoContextMenu(
              actions: [
                CupertinoContextMenuAction(
                  child: Text("Copy"),
                  onPressed: null,
                ),
                CupertinoContextMenuAction(
                  child: Text("Share"),
                  onPressed: null,
                ),
                CupertinoContextMenuAction(
                  isDestructiveAction: true,
                  child: Text("Delete"),
                  onPressed: null,
                ),
              ],
              child: Icon(
                CupertinoIcons.photo,
                size: 120,
                color: CupertinoColors.activeBlue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CupertinoContextMenuExample extends StatelessWidget {
  const CupertinoContextMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("CupertinoContextMenu Example"),
        ),
        child: SafeArea(
          child: Center(
            child: CupertinoContextMenu(
              actions: const [
                CupertinoContextMenuAction(
                  child: Text("Copy"),
                  onPressed: null,
                ),
                CupertinoContextMenuAction(
                  child: Text("Share"),
                  onPressed: null,
                ),
                CupertinoContextMenuAction(
                  isDestructiveAction: true,
                  child: Text("Delete"),
                  onPressed: null,
                ),
              ],
              child: const Image(
                image: NetworkImage(
                  "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg",
                ),
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CupertinoCheckBox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const CupertinoCheckBox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: value ? CupertinoColors.activeGreen : CupertinoColors.white,
          border: Border.all(color: CupertinoColors.activeGreen, width: 2),
          borderRadius: BorderRadius.circular(6),
        ),
        child:
            value
                ? const Icon(
                  CupertinoIcons.check_mark,
                  size: 18,
                  color: CupertinoColors.white,
                )
                : null,
      ),
    );
  }
}

class CupertinoCheckBoxExample extends StatefulWidget {
  const CupertinoCheckBoxExample({super.key});

  @override
  State<CupertinoCheckBoxExample> createState() =>
      _CupertinoCheckBoxExampleState();
}

class _CupertinoCheckBoxExampleState extends State<CupertinoCheckBoxExample> {
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("CupertinoCheckBox Example"),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoCheckBox(
                value: isAccepted,
                onChanged: (newValue) {
                  setState(() {
                    isAccepted = newValue;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text(
                isAccepted ? "Accepted ✅" : "Not Accepted ❌",
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CupertinoButtonExample extends StatelessWidget {
  const CupertinoButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("CupertinoButton Example"),
        ),
        child: Center(
          child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            borderRadius: BorderRadius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: const Text(
              "Press Me",
              style: TextStyle(color: CupertinoColors.white, fontSize: 18),
            ),
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder:
                    (_) => const CupertinoAlertDialog(
                      title: Text("Hello!"),
                      content: Text("You pressed the CupertinoButton."),
                    ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class AdaptiveTextSelectionExample extends StatelessWidget {
  const AdaptiveTextSelectionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text("Adaptive Text Selection"),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Center(
            child: SelectableText(
              "Try selecting this text.\n"
              "On iOS → Cupertino style toolbar\n"
              "On Android → Material style toolbar",
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

class ActivityIndicatorExample extends StatelessWidget {
  const ActivityIndicatorExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(middle: Text("Loading Example")),
        child: Center(
          child: CupertinoActivityIndicator(
            radius: 20, // حجم المؤشر
          ),
        ),
      ),
    );
  }
}

class ActionSheetExample extends StatelessWidget {
  const ActionSheetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text("CupertinoActionSheet Example"),
        ),
        child: Center(
          child: CupertinoButton.filled(
            child: const Text("Show ActionSheet"),
            onPressed: () {
              showCupertinoModalPopup(
                context: context,
                builder: (BuildContext context) {
                  return CupertinoActionSheet(
                    title: const Text("Choose an Option"),
                    message: const Text("Pick one of the actions below"),
                    actions: [
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Option 1"),
                      ),
                      CupertinoActionSheetAction(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        isDestructiveAction: true,
                        child: const Text("Delete"),
                      ),
                    ],
                    cancelButton: CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class AutocompleteExample extends StatelessWidget {
  final List<String> _options = [
    'تفاح',
    'موز',
    'برتقال',
    'كمثرى',
    'عنب',
    'أناناس',
  ];

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return const Iterable<String>.empty();
        }
        return _options.where(
          (option) => option.toLowerCase().contains(
            textEditingValue.text.toLowerCase(),
          ),
        );
      },
      onSelected: (String selection) {
        print('تم اختيار: $selection');
      },
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'اختر فاكهة',
          ),
        );
      },
    );
  }
}

class AnimatedSizeExample extends StatefulWidget {
  @override
  _AnimatedSizeExampleState createState() => _AnimatedSizeExampleState();
}

class _AnimatedSizeExampleState extends State<AnimatedSizeExample>
    with SingleTickerProviderStateMixin {
  bool _isBig = false;

  void _toggleSize() {
    setState(() {
      _isBig = !_isBig;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSize,
      child: AnimatedSize(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        child: Container(
          width: _isBig ? 200 : 100,
          height: _isBig ? 200 : 100,
          color: Colors.blue,
          alignment: Alignment.center,
          child: Text(
            'اضغط لتغيير الحجم',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AnimatedPositionedExample extends StatefulWidget {
  @override
  _AnimatedPositionedExampleState createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  bool _isTopLeft = true;

  void _togglePosition() {
    setState(() {
      _isTopLeft = !_isTopLeft;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: _togglePosition,
          child: Container(
            width: 300,
            height: 300,
            color: Colors.grey.shade200,
          ),
        ),
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          top: _isTopLeft ? 0 : 200,
          left: _isTopLeft ? 0 : 200,
          child: Container(width: 50, height: 50, color: Colors.blue),
        ),
      ],
    );
  }
}

class AnimatedPhysicalModelExample extends StatefulWidget {
  @override
  _AnimatedPhysicalModelExampleState createState() =>
      _AnimatedPhysicalModelExampleState();
}

class _AnimatedPhysicalModelExampleState
    extends State<AnimatedPhysicalModelExample> {
  bool _isElevated = false;

  void _toggleElevation() {
    setState(() {
      _isElevated = !_isElevated;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleElevation,
      child: AnimatedPhysicalModel(
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        elevation: _isElevated ? 20 : 2,
        shape: BoxShape.rectangle,
        shadowColor: Colors.black,
        color: _isElevated ? Colors.blue : Colors.red,
        borderRadius: BorderRadius.circular(_isElevated ? 30 : 0),
        child: Container(
          width: 150,
          height: 150,
          alignment: Alignment.center,
          child: Text(
            'اضغط للتغيير',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class AnimatedOpacityExample extends StatefulWidget {
  @override
  _AnimatedOpacityExampleState createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  double _opacity = 1.0;

  void _toggleOpacity() {
    setState(() {
      _opacity = _opacity == 1.0 ? 0.0 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleOpacity,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        child: Container(
          width: 150,
          height: 150,
          color: Colors.blue,
          child: Center(
            child: Text(
              'اضغط لتلاشي',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedModalBarrierExample extends StatefulWidget {
  @override
  _AnimatedModalBarrierExampleState createState() =>
      _AnimatedModalBarrierExampleState();
}

class _AnimatedModalBarrierExampleState
    extends State<AnimatedModalBarrierExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Colors.black54,
    ).animate(_controller);
  }

  void _toggleBarrier() {
    setState(() {
      _isVisible = !_isVisible;
      if (_isVisible) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: ElevatedButton(
            onPressed: _toggleBarrier,
            child: Text(_isVisible ? "إخفاء الحاجز" : "إظهار الحاجز"),
          ),
        ),
        if (_isVisible)
          AnimatedModalBarrier(color: _colorAnimation, dismissible: true),
      ],
    );
  }
}

class AnimatedListExample extends StatefulWidget {
  @override
  _AnimatedListExampleState createState() => _AnimatedListExampleState();
}

class _AnimatedListExampleState extends State<AnimatedListExample> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final List<int> _items = [];

  void _addItem() {
    final index = _items.length;
    _items.add(index);
    _listKey.currentState!.insertItem(index);
  }

  void _removeItem(int index) {
    final removedItem = _items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => _buildItem(removedItem, animation),
    );
  }

  Widget _buildItem(int item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: ListTile(
          title: Text('العنصر $item'),
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              final index = _items.indexOf(item);
              if (index >= 0) _removeItem(index);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(onPressed: _addItem, child: Text('إضافة عنصر')),
        Expanded(
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _items.length,
            itemBuilder: (context, index, animation) {
              return _buildItem(_items[index], animation);
            },
          ),
        ),
      ],
    );
  }
}

class AnimatedDefaultTextStyleExample extends StatefulWidget {
  @override
  _AnimatedDefaultTextStyleExampleState createState() =>
      _AnimatedDefaultTextStyleExampleState();
}

class _AnimatedDefaultTextStyleExampleState
    extends State<AnimatedDefaultTextStyleExample> {
  bool _isBig = false;

  void _toggleStyle() {
    setState(() {
      _isBig = !_isBig;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleStyle,
      child: AnimatedDefaultTextStyle(
        style: TextStyle(
          fontSize: _isBig ? 40 : 20,
          color: _isBig ? Colors.red : Colors.blue,
          fontWeight: _isBig ? FontWeight.bold : FontWeight.normal,
        ),
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
        child: Text('اضغط لتغيير النص'),
      ),
    );
  }
}

class AnimatedCrossFadeExample extends StatefulWidget {
  @override
  _AnimatedCrossFadeExampleState createState() =>
      _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  bool _showFirst = true;

  void _toggleWidget() {
    setState(() {
      _showFirst = !_showFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleWidget,
      child: AnimatedCrossFade(
        duration: Duration(seconds: 1),
        firstChild: Container(
          width: 150,
          height: 150,
          color: Colors.blue,
          child: Center(child: Text('الويجدت الأول')),
        ),
        secondChild: Container(
          width: 150,
          height: 150,
          color: Colors.green,
          child: Center(child: Text('الويجدت الثاني')),
        ),
        crossFadeState:
            _showFirst ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      ),
    );
  }
}

class AnimatedContainerExample extends StatefulWidget {
  @override
  _AnimatedContainerExampleState createState() =>
      _AnimatedContainerExampleState();
}

class _AnimatedContainerExampleState extends State<AnimatedContainerExample> {
  bool _isBig = false;

  void _toggleSize() {
    setState(() {
      _isBig = !_isBig;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSize,
      child: AnimatedContainer(
        width: _isBig ? 200 : 100,
        height: _isBig ? 200 : 100,
        color: _isBig ? Colors.blue : Colors.red,
        duration: Duration(seconds: 1),
        curve: Curves.easeInOut,
      ),
    );
  }
}

class AnimatedBuilderExample extends StatefulWidget {
  @override
  _AnimatedBuilderExampleState createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 50,
      end: 150,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          width: _animation.value,
          height: _animation.value,
          color: Colors.blue,
        );
      },
    );
  }
}

class AlignTransitionExample extends StatefulWidget {
  @override
  _AlignTransitionExampleState createState() => _AlignTransitionExampleState();
}

class _AlignTransitionExampleState extends State<AlignTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = AlignmentTween(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 300,
      color: Colors.grey.shade200,
      child: AlignTransition(
        alignment: _animation,
        child: Container(width: 50, height: 50, color: Colors.blue),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Alignment _alignment = Alignment.topLeft;

  void _changeAlignment() {
    setState(() {
      _alignment =
          _alignment == Alignment.topLeft
              ? Alignment.bottomRight
              : Alignment.topLeft;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeAlignment,
      child: Container(
        color: Colors.white,
        child: AnimatedAlign(
          alignment: _alignment,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
          child: Container(width: 60, height: 60, color: Colors.blue),
        ),
      ),
    );
  }
}
