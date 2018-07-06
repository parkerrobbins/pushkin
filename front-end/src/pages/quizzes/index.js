/**
 * React Static Boilerplate
 * https://github.com/kriasoft/react-static-boilerplate
 *
 * Copyright © 2015-present Kriasoft, LLC. All rights reserved.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.txt file in the root directory of this source tree.
 */

import React from 'react';
import s from './styles.css';
import quizzes from '../../quizzes/quizzes.js';
import { Link } from 'react-router';

class QuizPage extends React.Component {
	render() {
		if (this.props.children) return this.props.children;

		return (
			<div>
				<p>Quizzes</p>
				<Link to='/test'>TEST</Link>
				<ul>
					{
						quizzes.map(
							q => (<li key={q}><Link to={`/quizzes/${q}`}>{q.split('/')[0]}</Link></li>)
						)
					}
				</ul>
			</div>
		);
	}
}

export default QuizPage;
