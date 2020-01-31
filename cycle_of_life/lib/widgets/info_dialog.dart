import 'package:cycle_of_life/styles/colors.dart';
import 'package:flutter/material.dart';

class InfoDialog extends StatefulWidget {
  final String material;

  InfoDialog({this.material});

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  String capitalize(String s) {
    return s[0].toUpperCase() + s.substring(1);
  }

  RichText buildAppropriateText() {
    if (widget.material == 'plastic') {
      return buildPlasticRulesText();
    }
    if (widget.material == 'metal') {
      return buildMetalRulesText();
    }
    if (widget.material == 'glass') {
      return buildGlassRulesText();
    }
    if (widget.material == 'cardboard') {
      return buildCardboardRules();
    }
    if (widget.material == 'paper') {
      return buildPaperRulesText();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: kLighterWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildTextContainer(),
        ),
      ),
    );
  }

  Column buildTextContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Center(
          child: Text(
            "Recycling Rules for ${capitalize(widget.material)}",
            style: TextStyle(
              fontFamily: 'Raleway',
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Expanded(
          child: SingleChildScrollView(
            child: buildAppropriateText(),
          ),
        )
      ],
    );
  }

  RichText buildMetalRulesText() {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 14.0,
      ),
        children: <TextSpan>[
          TextSpan(
            text: 'Good\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.green,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'All kinds except for the below\n\n',
          ),
          TextSpan(
            text: 'Bad\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Batteries\nElectronic devices banned from disposal',
          )
        ],
      ),
    );
  }

  RichText buildGlassRulesText() {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 14.0,
      ),
        children: <TextSpan>[
          TextSpan(
            text: 'Good\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.green,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Glass bottles\nJars\n\n',
          ),
          TextSpan(
            text: 'Bad\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Glass items other than glass bottles and jars',
          )
        ],
      ),
    );
  }

  RichText buildPlasticRulesText() {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 14.0,
      ),
        children: <TextSpan>[
          TextSpan(
            text: 'Good\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.green,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Plastic bottles\nJugs\nJars\nRigid plastic caps and lids\n',
          ),
          TextSpan(
            text: 'Rigid plastic food containers\n',
          ),
          TextSpan(
            text: 'Rigid plastic non-food containers\n',
          ),
          TextSpan(
            text: 'Rigid plastic housewares\n',
          ),
          TextSpan(
            text: 'Bulk rigid plastic\n\n',
          ),

          TextSpan(
            text: 'Bad\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Rigid plastic containers containing medical “sharps” or disposable razors\n',
          ),
          TextSpan(
            text: 'Foam plastic items \n',
          ),
          TextSpan(
            text: 'Flexible plastic items\n',
          ),
          TextSpan(
            text: 'Film plastic (such as plastic shopping bags and wrappers). Bring plastic bags and film to participating stores for recycling\n',
          ),
          TextSpan(
            text: 'Pens and markers',
          ),
        ],
      ),
    );
  }

  RichText buildPaperRulesText() {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 14.0,
      ),
        children: <TextSpan>[
          TextSpan(
            text: 'Good\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.green,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Newspapers, magazines, catalogs, phone books, mixed paper\n',
          ),
          TextSpan(
            text: 'White and colored paper (staples are ok)\n',
          ),
          TextSpan(
            text: 'Mail and envelopes (window envelopes are ok)\n',
          ),
          TextSpan(
            text: 'Receipts\n',
          ),
          TextSpan(
            text: 'Paper bags (handles ok)\n',
          ),
          TextSpan(
            text: 'Wrapping paper\n',
          ),
          TextSpan(
            text: 'Soft-cover books (no spiral bindings)\n\n',
          ),
          TextSpan(
            text: 'Bad\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Paper with heavy wax or plastic coating\n',
          ),
          TextSpan(
            text: 'Soiled or soft paper (napkins, paper towels, tissues)\n',
          ),
          TextSpan(
            text: 'Hardcover books',
          )
        ],
      ),
    );
  }

  RichText buildCardboardRules() {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(
        fontFamily: 'Raleway',
        color: Colors.black,
        fontSize: 14.0,
      ),
        children: <TextSpan>[
          TextSpan(
            text: 'Good\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.green,
              fontSize: 18.0,
            ),
          ),
          TextSpan(
            text: 'Cardboard egg cartons\n',
          ),
          TextSpan(
            text: 'Cardboard trays\n',
          ),

          TextSpan(
            text: 'Smooth cardboard\n',
          ),

          TextSpan(
            text: 'Pizza boxes (remove and discard soiled liner; recycle little plastic supporter with rigid plastics)\n',
          ),

          TextSpan(
            text: 'Paper cups (waxy lining ok if cups are empty and clean; recycle plastic lids with rigid plastics)\n',
          ),

          TextSpan(
            text: 'Corrugated cardboard boxes (flattened and tied together with sturdy twine)\n\n',
          ),

          TextSpan(
            text: 'Bad\n',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w700,
              color: Colors.red,
              fontSize: 18.0,
            ),
          ),
        ],
      ),
    );
  }
  
}
