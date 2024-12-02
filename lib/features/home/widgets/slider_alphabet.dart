import 'package:contacts_manager/features/home/bloc/bloc.dart';
import 'package:contacts_manager/features/home/widgets/widgets.dart';
import 'package:contacts_manager/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SliderAlphabet extends StatefulWidget {
  const SliderAlphabet({super.key});

  @override
  State<SliderAlphabet> createState() => _SliderAlphabetState();
}

class _SliderAlphabetState extends State<SliderAlphabet> {
  @override
  Widget build(BuildContext context) {
    final initialLetters =
        context.select((HomeBloc bloc) => bloc.state.initialLetters);

    final selectedLetterIndex =
        context.select((HomeBloc bloc) => bloc.state.selectedLetterIndex);

    return SizedBox(
      height: 500,
      width: 70,
      child: RotatedBox(
        quarterTurns: 1,
        child: SliderTheme(
          data: SliderThemeData(
            trackShape: LetterSliderTrackShape(
              lettersList: initialLetters,
            ),
            thumbShape:
                CustomThumbShape(letter: initialLetters[selectedLetterIndex]),
            thumbColor: Colors.deepPurple,
            overlayColor: Colors.transparent,
          ),
          child: Slider(
            min: UISpacing.zero,
            max: initialLetters.length.toDouble() - 1,
            value: selectedLetterIndex.toDouble(),
            label: initialLetters[selectedLetterIndex],
            onChanged: (newValue) {
              context
                  .read<HomeBloc>()
                  .add(ChangeSelectedLetterIndex(newValue.toInt()));
            },
          ),
        ),
      ),
    );
  }
}
