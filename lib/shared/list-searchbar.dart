// Libs
import 'package:flutter/material.dart';

// Widgets
import 'package:cook/shared/ink-wrapper.dart';

class ListSearchbar extends StatefulWidget {
  
  final String title;
  final Function onSearch;

  ListSearchbar({
    @required this.title,
    @required this.onSearch
  });

  @override
  _ListSearchbarState createState() => _ListSearchbarState();
}

class _ListSearchbarState extends State<ListSearchbar> {

  final _searchTermController = TextEditingController();
  String _searchTerm = '';

  void _triggerSearch() {
    widget.onSearch(_searchTermController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 15.0),
      decoration: BoxDecoration(
        color: Colors.blue[800],
        image: DecorationImage(
          image: AssetImage('assets/images/main-topbar.png'),
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5.0,
            spreadRadius: 1.0,
            offset: Offset(0.0, 4.0),
          )
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0
                  ),
                ),
                InkWrapper(
                  borderRadius: BorderRadius.circular(40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 28.0
                    ),
                    onPressed: () {},
                  ),
                  onTap: () => print('open filter'),
                )
              ],
            ),
          ),
          SizedBox(height: 0.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40.0)
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchTermController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: 'Search...',
                      contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                    ),
                    onChanged: (String value) =>
                      setState(() => _searchTerm = value),
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      _triggerSearch();
                    }
                  )
                ),
                InkWrapper(
                  borderRadius: BorderRadius.circular(40.0),
                  child: IconButton(icon: Icon(Icons.search), onPressed: () {}),
                  onTap: _triggerSearch,
                ),
                if (_searchTerm.length > 0)
                  InkWrapper(
                    borderRadius: BorderRadius.circular(40.0),
                    child: IconButton(icon: Icon(Icons.clear), onPressed: () {}),
                    onTap: () {
                      _searchTermController.clear();
                      _triggerSearch();
                    },
                  )
              ]
            ),
          ),
        ]
      )
    );
  }
}