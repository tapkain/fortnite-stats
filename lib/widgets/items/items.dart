import 'package:flutter/material.dart';
import 'package:fortnite_stats/util/api_client.dart';
import 'package:fortnite_stats/model/fortnite_items.dart';

class FortniteItemsList extends StatefulWidget {
  ApiClient apiClient;

  FortniteItemsList({this.apiClient});

  @override
  _FortniteItemsListState createState() {
    return _FortniteItemsListState(apiClient: apiClient);
  }
}

class _FortniteItemsListState extends State<FortniteItemsList> {
  ApiClient apiClient;
  FortniteItems _model;
  var _itemsQuery = FortniteItemsQuery.current;

  _FortniteItemsListState({this.apiClient});

  @override
  void initState() {
    _refreshItems();
    super.initState();
  }

  Future<Null> _refreshItems() {
    return apiClient.fetchStoreItems(_itemsQuery).then((i) {
      setState(() {
        _model = i;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_model == null) {
      return Container(
        alignment: Alignment.center,
        color: Colors.white,
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: _buildSwitcher(),
            ),
            Expanded(
              child: _buildItemsGrid(),
            )
          ],
        ),
      );
    }
  }

  Widget _buildSwitcherButton(String text, bool isSelected) {
    return OutlineButton(
      onPressed: () {
        if (isSelected) {
          return;
        }

        setState(() {
          _itemsQuery = _itemsQuery == FortniteItemsQuery.current
              ? FortniteItemsQuery.upcoming
              : FortniteItemsQuery.current;
          _refreshItems();
        });
      },
      child: Text(text),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      borderSide:
          BorderSide(color: isSelected ? Colors.redAccent : Colors.white),
    );
  }

  Widget _buildSwitcher() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _buildSwitcherButton(
          'Current',
          _itemsQuery == FortniteItemsQuery.current,
        ),
        SizedBox(
          width: 8,
        ),
        _buildSwitcherButton(
          'Upcoming',
          _itemsQuery == FortniteItemsQuery.upcoming,
        ),
      ],
    );
  }

  Widget _buildItemsGrid() {
    return RefreshIndicator(
      onRefresh: () {
        return _refreshItems();
      },
      child: GridView.builder(
        itemCount: _model.items.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return _buildItem(context, _model.items[index]);
        },
      ),
    );
  }

  Widget _buildItem(BuildContext context, FortniteItem item) {
    return GestureDetector(
      child: Image.network(item.mainImage),
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      color: Colors.grey[200],
                      child: Column(
                        children: <Widget>[
                          Image.network(item.featuredImage),
                          Text(
                            item.name,
                            style: Theme.of(context).textTheme.title,
                          ),
                          Text(
                            'Type - ${item.type ?? '???'}',
                            style: Theme.of(context).textTheme.body1,
                          ),
                          Text(
                            'Cost - ${item.cost ?? '???'}',
                            style: Theme.of(context).textTheme.body1,
                          ),
                        ],
                      )),
                )
              ],
            );
          },
        );
      },
    );
  }
}
